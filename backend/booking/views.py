from datetime import date
from django.shortcuts import render,get_object_or_404
from rest_framework import generics,viewsets
from .models import Room,Booking,Hotel
from hotel.models import User
from .serializer import RoomSerializer,BookingSerializer,HotelSerializer
from django.http import JsonResponse
from .models import *
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view


@api_view(['POST'])
def make_reservation(request):
    if request.method == 'POST':
        try:
            username = request.data['username']
            room_id = request.data['room_id']
            datee = request.data['date']
            print(str(username)+" "+str(room_id)+" "+str(datee))
        except:
            return Response(
                {
                    'message':"envoyer tous les champs"
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        try:
            room = Room.objects.get(id=room_id)
            user = User.objects.get(username=username)
            reservation = Booking.objects.create(
                room=room,
                user=user,
                date=date.today()
            )
            return Response(
                {
                    'message':"Parfait"
                },
                status=status.HTTP_201_CREATED
            )
        except Room.DoesNotExist:
            return Response(
                {
                    'message':"Room doesnt exist"
                },
                status=status.HTTP_400_BAD_REQUEST
            )
        except:
            return Response(
                {
                    'message':"data are not valid"
                },
                status=status.HTTP_400_BAD_REQUEST
            )
    return JsonResponse({'status': 'error', 'message': 'Invalid request method'})


def reservation_view(request, username, room_id, date):
    user = get_object_or_404(User, username=username)
    room = get_object_or_404(Room, pk=room_id)
    reservation = get_object_or_404(Booking, room=room, user=user, date=date)
    return render(request, 'reservation.html', {'reservation': reservation})

# Reservation
class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer


# Create your views here.
class HotelListView(generics.ListAPIView):
    queryset=Hotel.objects.all()
    serializer_class=HotelSerializer
    
class RoomViewSet(viewsets.ModelViewSet):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    def get_queryset(self):
        hotel_id = self.kwargs['hotel_id']
        return Room.objects.filter(hotel_id=hotel_id)    

class BookingViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer

    def get_queryset(self):
        user_id = self.kwargs['user_id']
        return Booking.objects.filter(user_id=user_id)    
    
class RoomReservationView(generics.RetrieveUpdateAPIView):
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    def perform_update(self, serializer):
        room = self.get_object()
        room.available = False
        room.save()
    
class RoomListView(generics.ListAPIView):
    queryset=Room.objects.all()
    serializer_class=RoomSerializer
    
class BookingListView(generics.ListAPIView):
    queryset=Booking.objects.all()
    serializer_class=BookingSerializer
    
    
# Search Hotel
class HotelSearchView(generics.ListAPIView):
    serializer_class = HotelSerializer

    def get_queryset(self):
        place = self.kwargs.get('place', None)
        if place is not None:
            return Hotel.objects.filter(place__iexact=place)
        return Hotel.objects.none()