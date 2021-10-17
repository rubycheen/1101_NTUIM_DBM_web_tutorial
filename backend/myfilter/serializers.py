from rest_framework import serializers
from myfilter.models import Discount, Fare, Schedule, Station, Train

class StationListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Station
        fields = '__all__'
