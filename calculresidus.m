function Ri = calculresidus(Z)

        a=1;
        tf=1;
        pas=0.05;
        N=tf/pas +1;
        
        x=Z(1:N,1);
        y=Z(N+1:2*N,1);
        vx=Z(2*N+1:3*N,1);
        vy=Z(3*N+1:4*N,1);
        u=Z(4*N+1:5*N,1);
        
        X=[x y vx vy];
        
        dx=vx;
        dy=vy;
        dvx=a*cos(u);
        dvy=a*sin(u);
        
        F=[dx dy dvx dvy];
        
        for i=1:length(x)-1
            Xc(i,:)=1/2*(X(i,:)+X(i+1,:))-pas/8*(F(i+1,:)-F(i,:));
            Uc(i,1)=1/2*(u(i)+u(i+1));
        end
        
        dxc=Xc(:,3);
        dyc=Xc(:,4);
        dvxc=a*cos(Uc);
        dvyc=a*sin(Uc);
        
        Fc=[ dxc dyc dvxc dvyc];
        
        for i=1:length(x)-1
            R(:,i)=X(i+1,:)'-X(i,:)'-pas/6*(F(i,:)'+4*Fc(i,:)'+F(i+1,:)');
        end
        Ri=reshape(R, size(R,2)*size(R,1), 1);
end

