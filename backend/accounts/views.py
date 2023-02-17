from .models import *
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view

@api_view(['POST'])
def login(request):
    uuu = request.data['username']
    ppp = request.data['password']
    null=None
    try:
        user=authenticate(username=uuu,password=ppp)
    except:

        return Response(
            {
                'status': False,
                'message': 'Les donnees 5asrin ye waj3a',
                'data': null
            },
            status.HTTP_400_BAD_REQUEST
        )
        
    try:
        try:
            token = Token.objects.get(user=user)
        except:
            token = Token.objects.create(user=user)
        print({
                'id':user.id,
                'status': True,
                'token': str(token),
                'message':'login success',
                
            })
        return Response(
            {
                'id':user.id,
                'status': True,
                'token': str(token),
                'message':'login success',
                
            },
            status.HTTP_200_OK
        )
    except:
        return Response(
            {
                'status': False,
                'message': 'Les donnees 5asrin ye waj3a',
                'data': null
            },
            status.HTTP_400_BAD_REQUEST
        )
        
        
