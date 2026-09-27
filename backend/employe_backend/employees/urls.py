from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from .views import EmployeeViewSet, RegisterView


router = DefaultRouter()

router.register('employees', EmployeeViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('register/', RegisterView.as_view()),

    path('token/', TokenObtainPairView.as_view()),
    path('token/refresh/', TokenRefreshView.as_view()),
]