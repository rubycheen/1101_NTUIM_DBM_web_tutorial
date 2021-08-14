from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from filter.models import Discount, Fare, Schedule, Station, Train
from filter.serializers import StationListSerializer

from django.db.models import Count
import datetime

# https://www.django-rest-framework.org/api-guide/status-codes/

@api_view(['GET'])
def station_list(request):
    if request.method == 'GET':
        stations = Station.objects.all() #這邊用的 queryset 就是 ORM
        serializer = StationListSerializer(stations, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    # elif request.method == 'POST':
    #     serializer = StationSerializer(data=request.data)
        # if serializer.is_valid():
        #     serializer.save()
        #     return Response(serializer.data, status=status.HTTP_201_CREATED)
        # return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def timetable_search(request):
    
    if request.method == 'POST':
        start_ = request.data['StartStation']
        end_ = request.data['EndStation']
        date_ = request.data['OutWardSearchDate']
        time_ = request.data['OutWardSearchTime']
        start_id = Station.objects.filter(station_name=start_).values('station_id')[0]['station_id']
        end_id = Station.objects.filter(station_name=end_).values('station_id')[0]['station_id']
        weekday = datetime.datetime.strptime(date_, '%Y/%m/%d').strftime('%a').lower()
        search_time = datetime.datetime.strptime(date_, '%Y/%m/%d')
        # 訂票五天前的00:00算早鳥
        # hour, minute = [int(i) for i in time_.split(':')]
        # search_time = search_time.replace(hour=hour, minute=minute)
        
        potential_tids = Train.objects.filter(starting_station_id__lte=start_id, ending_station_id__gte=end_id)

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
        two_schedules = schedules.values('train_id').annotate(tid_cnt=Count('station_id')).filter(tid_cnt__gt=1).values('train_id')
        two_schedule_ids = [s['train_id'] for s in two_schedules]
        schedules = schedules.filter(train_id__in=two_schedule_ids)

        result = []
        for _id, (start, end) in enumerate(zip(schedules[::2], schedules[1::2]), start=1):
            
            data = {'key': _id}
            
            start_time = datetime.datetime.strptime(start['departure_time'], '%H:%M')
            end_time = datetime.datetime.strptime(end['arrival_time'], '%H:%M')
            spend = (end_time - start_time).seconds // 60
            current_time = datetime.datetime.now()

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

        return Response(result, status=status.HTTP_200_OK)
        

@api_view(['POST'])
def ticket_search(request):
    if request.method == 'POST':
        start_ = request.data['StartStation']
        end_ = request.data['EndStation']
        date_ = request.data['OutWardSearchDate']
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
        
        # return Response("Temp Error", status=status.HTTP_400_BAD_REQUEST)