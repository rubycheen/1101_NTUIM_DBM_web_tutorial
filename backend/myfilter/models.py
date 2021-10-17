# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Discount(models.Model):
    discount_id = models.AutoField(primary_key=True)
    type = models.TextField()
    discount_rate = models.FloatField(blank=True, null=True)

    class Meta:
        db_table = 'THSR"."discount'

    def __str__(self):
        return self.type

class Fare(models.Model):
    fare_id = models.AutoField(primary_key=True)
    origin_station = models.ForeignKey('Station', on_delete=models.CASCADE, related_name='origin')
    destination_station = models.ForeignKey('Station', on_delete=models.CASCADE, related_name='destination') #related_name是為了解決reverse accessor的錯誤
    business_fare = models.FloatField()
    standard_fare = models.FloatField()
    non_reserved_fare = models.FloatField()

    class Meta:
        db_table = 'THSR"."fare' #corresponded table name in DB, dufault value: myapp_classname

    def __str__(self):
        return f'{self.origin_station}2{self.destination_station}_fare'


class Schedule(models.Model):
    schedule_id = models.AutoField(primary_key=True)
    train = models.ForeignKey('Train', on_delete=models.CASCADE)
    stop_sequence = models.IntegerField()
    station = models.ForeignKey('Station', on_delete=models.CASCADE)
    arrival_time = models.TextField(blank=True, null=True)
    departure_time = models.TextField(blank=True, null=True)

    class Meta:
        db_table = 'THSR"."schedule'

    def __str__(self):
        return f'{self.train}_{self.station}'


class Station(models.Model):
    station_id = models.TextField(primary_key=True)
    station_name = models.TextField()

    class Meta:
        db_table = 'THSR"."station'
    
    def __str__(self):
        return self.station_name


class Train(models.Model):
    train_id = models.TextField(primary_key=True)
    starting_station = models.ForeignKey(Station, on_delete=models.CASCADE, related_name='starting')
    ending_station = models.ForeignKey(Station, on_delete=models.CASCADE, related_name='ending')
    mon = models.BooleanField()
    tue = models.BooleanField()
    wed = models.BooleanField()
    thu = models.BooleanField()
    fri = models.BooleanField()
    sat = models.BooleanField()
    sun = models.BooleanField()

    class Meta:
        db_table = 'THSR"."train'

    def __str__(self):
        return f'{self.starting_station}2{self.ending_station}_{self.wed}'