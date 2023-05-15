function [ C, Ceq ] = contraintes_nonlin(Z)


    C=[];
    Ceq = [];
    tf=1;
    pas=0.05;
    N=tf/pas +1;
    
    
    for i=1:N
        C = [C; 14.0625*Z(i)^3 - 12.1875*Z(i)^2 + 3*Z(i) - Z(N+i) ;...
            Z(N+i) - 17.1875* Z(i)^3 + 15.3125*Z(i)^2 - 4*Z(i)];
    end
    
    Ceq=calculresidus(Z);
end

