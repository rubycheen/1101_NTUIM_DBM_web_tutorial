from rest_framework import serializers
from filter.models import Discount, Fare, Schedule, Station, Train

class StationListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Station
        fields = '__all__'

# class TimetableSearchSerializer(serializers.serializer):
#     start_station = serializers.CharField(max_length=100)
#     end_station = serializers.CharField(max_length=100)
#     outward_search_date = serializers.CharField(max_length=100)
#     outward_search_time = serializers.CharField(max_length=100)

#     def validate(self, data):
#         """
#         Check search time is after current time
#         """
#         search_time = 