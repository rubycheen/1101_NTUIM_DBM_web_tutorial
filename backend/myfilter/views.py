from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from myfilter.models import Discount, Fare, Schedule, Station, Train
from myfilter.serializers import StationListSerializer

from django.db.models import Count
import datetime

# https://www.django-rest-framework.org/api-guide/status-codes/

@api_view(['GET'])
def station_list(request):
    if request.method == 'GET':
        stations = Station.objects.all()
        serializer = StationListSerializer(stations, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
def timetable_search(request):
    if 'application/json' not in request.content_type:
        return Response("Content type should be 'application/json'.", status=status.HTTP_400_BAD_REQUEST)
    
    if request.method == 'POST':
        try:
            start_ = request.data['StartStation']
            end_ = request.data['EndStation']
            date_ = request.data['OutWardSearchDate']
            time_ = request.data['OutWardSearchTime']
        except KeyError:
            return Response("4 parameters are all required.(StartStation,EndStation,OutWardSearchDate,OutWardSearchTime)", status=status.HTTP_400_BAD_REQUEST)

        start_id = Station.objects.filter(station_name=start_).values('station_id')[0]['station_id']
        end_id = Station.objects.filter(station_name=end_).values('station_id')[0]['station_id']
        weekday = datetime.datetime.strptime(date_, '%Y/%m/%d').strftime('%a').lower()
        search_time = datetime.datetime.strptime(date_, '%Y/%m/%d')
        hour, minute = [int(i) for i in time_.split(':')]
        search_time = search_time.replace(hour=hour, minute=minute)
        is_northward = True if start_id < end_id else False
        print(f"weekday: {weekday}, search_time: {search_time}, start_id: {start_id}, end_id: {end_id}, is_northward: {is_northward}")

        if search_time < datetime.datetime.now():
            return Response("Search time is expired.", status=status.HTTP_400_BAD_REQUEST)

        # 找出有行經 start_station 到 end_station 的車次存在 potential_tids
        potential_tids = None
        if is_northward:
            potential_tids = Train.objects.filter(starting_station_id__lte=start_id, ending_station_id__gte=end_id)
        else:
            potential_tids = Train.objects.filter(starting_station_id__gte=start_id, ending_station_id__lte=end_id)

        if weekday == 'mon':
            potential_tids = potential_tids.filter(mon=True).values('train_id')
        elif weekday == 'tue':
            potential_tids = potential_tids.filter(tue=True).values('train_id')
        elif weekday == 'wed':
            potential_tids = potential_tids.filter(wed=True).values('train_id')
        elif weekday == 'thu':
            potential_tids = potential_tids.filter(thu=True).values('train_id')
        elif weekday == 'fri':
            potential_tids = potential_tids.filter(fri=True).values('train_id')
        elif weekday == 'sat':
            potential_tids = potential_tids.filter(sat=True).values('train_id')
        elif weekday == 'sun':
            potential_tids = potential_tids.filter(sun=True).values('train_id')
        potential_tids = [tobj['train_id'] for tobj in potential_tids]
        
        schedules = Schedule.objects.filter(station_id__in=[start_id, end_id], train_id__in=potential_tids)
        schedules = schedules.values('train_id', 'station_id', 'arrival_time', 'departure_time')
        # Each train_id, each with a count of station_id as a "tid_cnt" attribute. If "tid_cnt" >= 2 then this train_id stops by both start and end stations.
        two_schedules = schedules.values('train_id').annotate(tid_cnt=Count('station_id')).filter(tid_cnt__gt=1).values('train_id')
        two_schedule_ids = [s['train_id'] for s in two_schedules]
        schedules = schedules.filter(train_id__in=two_schedule_ids)


        result = []
        for _id, (start, end) in enumerate(zip(schedules[::2], schedules[1::2]), start=1):
            data = {}
            
            date_str = search_time.strftime("%d/%B/%Y")
            start_time = datetime.datetime.strptime(f"{date_str} {start['departure_time']}", '%d/%B/%Y %H:%M')
            end_time = datetime.datetime.strptime(end['arrival_time'], '%H:%M')
            
            spend = (end_time - start_time).seconds // 60
            current_time = datetime.datetime.now()

            # The departure_time should be later than search_time
            if start_time <= search_time:
                continue

            # print(start['train_id'], start['departure_time'], end['train_id'], end['arrival_time'])
            # print(Train.objects.filter(train_id=start['train_id']).get())

            data['startTime'] = start['departure_time']
            data['arrivalTime'] = end['arrival_time']
            data['timeSpend'] = spend
            data['number'] = start['train_id']

            if(search_time - current_time > datetime.timedelta(days=5)):
                data['earlyBird'] = True
            else:
                data['earlyBird'] = False

            if start_time.hour >= 21:
                data['undergraduate'] = True
            else:
                data['undergraduate'] = False

            result.append(data)

        # sort by startTime
        result = sorted(result, key=lambda d: d['startTime'])
        # add key
        new_result = []
        for i, d in enumerate(result, start=1):
            d.setdefault('key',i)
            new_result.append(d)
        return Response(new_result, status=status.HTTP_200_OK)
        

@api_view(['POST'])
def ticket_search(request):
    if 'application/json' not in request.content_type:
        return Response("Content type should be 'application/json'.", status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'POST':
        try:
            start_ = request.data['StartStation']
            end_ = request.data['EndStation']
            date_ = request.data['OutWardSearchDate']
        except KeyError:
            return Response("3 parameters are all required.(StartStation,EndStation,OutWardSearchDate)", status=status.HTTP_400_BAD_REQUEST)
            
        start_id = Station.objects.filter(station_name=start_).values('station_id')[0]['station_id']
        end_id = Station.objects.filter(station_name=end_).values('station_id')[0]['station_id']
        weekday = datetime.datetime.strptime(date_, '%Y/%m/%d').strftime('%a').lower()
        
        original_fares = Fare.objects.filter(origin_station_id=start_id, destination_station_id=end_id).values('business_fare', 'standard_fare', 'non_reserved_fare')[0]
        discounts = Discount.objects.all()
        discount_rates = {}
        for dr in discounts:
            discount_rates[dr.type] = dr.discount_rate

        result = []
        category_name = {'business_fare': '商務車廂', 'standard_fare':'標準車廂', 'non_reserved_fare':'自由座車廂'}
        for _id, (category, fare) in enumerate(original_fares.items(), start=1): 
            data = {}
            data['key'] = _id
            data['type'] = category_name[category]
            data['full'] = int(fare)
            data['discount'] = int(fare * discount_rates['concession'])
            data['earlyBird'] = int(fare * discount_rates['early_bird'])
            data['undergraduate'] = int(fare * discount_rates['undergraduate'])
            data['group'] = int(fare * discount_rates['group'])
            result.append(data)
        
        return Response(result, status=status.HTTP_200_OK)
        