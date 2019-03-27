x0 = [0;30];
dt = 1*10^(-3);
A = [1;0];
Ad = eye(2) + A * dt;
Bd = [dt^2/2;dt];
C = eye(2);
D = [0;0];

acc_breaks = [ 0 0 0 1 8 8];
acc_breakpoints = 0:1:5;