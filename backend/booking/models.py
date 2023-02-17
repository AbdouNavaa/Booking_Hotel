from django.db import models
from hotel.models import User

# Create your models here.
class Hotel(models.Model):
    name=models.CharField(max_length=255)
    place= models.CharField( max_length=255)
    image = models.ImageField(null=True)
    likes = models.IntegerField()
    
    def __str__(self):
        return self.name
class Room(models.Model):
    hotel=models.ForeignKey(Hotel, on_delete=models.CASCADE,null=True)
    type=models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    available = models.BooleanField(default=True)
    image = models.ImageField(null=True)
    
    def __str__(self):
        return self.type
class Booking(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    room = models.ForeignKey(Room, on_delete=models.CASCADE,null=True)
    date = models.DateField(null=True)
    
   
    def __str__(self):
        return f"{self.user.username} reserved {self.room} on {self.date}"