@echo off
:loop
cls
kubectl get pods
timeout /t 1 >nul
goto loop
