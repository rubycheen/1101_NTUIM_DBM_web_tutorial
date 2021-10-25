from django.urls import path
from myfilter import views

urlpatterns = [
    path('stations', views.station_list),
    path('timetable/search', views.timetable_search),
    path('ticket/search', views.ticket_search)
]