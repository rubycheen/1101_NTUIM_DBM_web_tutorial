from django.conf.urls import url
from filter import views

urlpatterns = [
    url('stations', views.station_list),
    url('timetable/search', views.timetable_search),
    url('ticket/search', views.ticket_search)
]