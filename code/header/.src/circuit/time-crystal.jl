


function brickwall_dtc(L,thetamean,epsilon)
  
    #Constructing the background Z field
    
        h=rand(L)*2*pi;
        Ind=collect(1:L)
        ZRow=copy(kron_list(RZ.(h),Ind));

 
        #Constructing the Random Brickwall 


            J=rand(L)*pi;                     #Ising Even Disorder on the two body gates

            fonez=copy(kron(Z,Z))               #
            ftwox=copy(kron(X,X));              #For the two body XX+YY gates
            ftwoy=copy(kron(Y,Y));              #

    
            thetadev=pi/50;
            theta=thetamean+randn(1)[]*thetadev;               #Interaction (Normal sampling)
                                      
            delh=randn(4)*pi/50;                                          #Imperfection in Z tuning (Normal sampling)

        FU=fill(fill(0.1+im, 4,4), L);


        for j in 1:length(FU)
        
            int1=kron(RZ(delh[1]),RZ(delh[2]));
                int2=exp(-im*J[j]*fonez-im*theta/2*(ftwox+ftwoy));
                int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[j]=int3*int2*int1;
            end

        Indodd=collect(1:2:L-1);    
        Indeven=collect(2:2:L-1);    
        
        # for even L

        if L%2==0
           

        UOdd=copy(kron_list(FU,Indodd));
        UEven=copy(kron(I(2),kron_list(FU,Indeven),I(2)));
 
        end

        # for odd L

        if L%2==1
        
        UOdd=copy(kron(kron_list(FU,Indodd)),I(2));
        UEven=copy(kron(I(2),kron_list(FU,Indeven)));
        end
            


        #Constructing the X Kicks 
 
            g=pi*(1-epsilon);
            XRow=copy(kron_power(RX(g),L));


          A=XRow*UEven*UOdd*ZRow;
          

 A    
end
;
