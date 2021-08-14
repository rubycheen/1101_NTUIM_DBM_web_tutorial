from rest_framework import serializers
from filter.models import Discount, Fare, Schedule, Station, Train

class StationListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Station
        fields = '__all__'

# class DiscountSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Discount
#         fields = '__all__'

# class FareSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Fare
#         fields = '__all__'

# class ScheduleSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Schedule
#         fields = '__all__'

# class StationSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Station
#         fields = '__all__'

# class TrainSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Train
#         fields = '__all__'