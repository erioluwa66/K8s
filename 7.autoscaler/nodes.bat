@echo off
:loop
cls
kubectl get nodes
timeout /t 1 >nul
goto loop
