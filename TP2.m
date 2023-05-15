clear all
close all
clc

x0=0;
t0=0;
yf=0.2;
tf=1;
a=1;

pas=0.05;
N=tf/pas +1;

for i=1:N
    t(i)=(i-1)*pas;
end

Z0=zeros(5*N,1);

Aeq=zeros(6,5*N);
Aeq(1,1)=1;
Aeq(2,N+1)=1;
Aeq(3,2*N)=1;
Aeq(4,2*N+1)=1;
Aeq(5,3*N+1)=1;
Aeq(6,4*N)=1;
Beq=[0 ; 0 ; yf ; 0 ; 0 ; 0 ];

A=zeros(2*N,5*N);
for i=1:N
    A(i,4*N+i)=-1;
end
for i=1:N-1
    A(i,4*N+i+1)=1;
end
for i=1:N
    A(N+i,4*N+i)=1;
end
for i=1:N-1
    A(N+i,4*N+i+1)=-1;
end

A(N,5*N)=0;
A(2*N,5*N)=0;
B=0.65*pas*ones(2*N,1);

options.MaxFunEvals = 30000;
options.TolFun = 1e-3;
options.TolX = 1e-6;
options.TolCon = 1e-3;
options.MaxIter = 2000;
%options.Algorithm = 'sqp';
[Zopt, fval, exitflag, output]=fmincon(@fct_cout,Z0,A,B,Aeq,Beq,[],[],@contraintes_nonlin,options);

X=Zopt(1:N);
Y=Zopt(N+1:2*N);
Vx=Zopt(2*N+1:3*N);
Vy=Zopt(3*N+1:4*N);
U=Zopt(4*N+1:5*N);

gamma_inf = 14.0625*X.^3 - 12.1875*X.^2 + 3*X;
gamma_sup = 17.1875*X.^3 - 15.3125*X.^2 + 4*X;

figure(1)
plot(t,U)
xlabel('t');
ylabel('u');
figure(2)
subplot(2,2,1)
plot(t,X)
xlabel('t');
ylabel('x');
subplot(2,2,3)
plot(t,Vx)
xlabel('t');
ylabel('Vx');
subplot(2,2,2)
plot(t,Y)
xlabel('t');
ylabel('y');
subplot(2,2,4)
plot(t,Vy)
xlabel('t');
ylabel('Vy');
figure(3)
hold on
plot(X,Y)
xlabel('x');
ylabel('y');
plot(X,gamma_inf,'r--')
plot(X,gamma_sup,'r--')
