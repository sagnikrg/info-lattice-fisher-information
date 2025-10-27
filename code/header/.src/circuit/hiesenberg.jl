

#################################
# Dependencies
#################################

include("brickwall.jl")




function circuit_heisenberg(L,Jmean, thetamean)
  
    
###########################################    
# Defining the indices
###########################################

        Ind=collect(1:L)

 #########################################
 # Background Disorder for the Z field
 #########################################

        h=rand(L)*2*pi;
        ZRow=RZ.(h);


 ###########################################
 #Constructing the Random Brickwall 
 ###########################################

        #J=fill(Jmean, L);             #F Fixed strength on ZZ
        J=Jmean
        fonez=copy(kron(Z,Z))
        ftwox=copy(kron(X,X));    #For the two body XX+YY gates
        ftwoy=copy(kron(Y,Y));


        #thetadev=pi/50;
        theta=thetamean #+randn(1)[]*thetadev;    #Interaction (Noise not included)
                                  
        #############################################
        # Defining two body gates as array of Tensors        
        ##############################################
  
        FU=fill(fill(0.0*im, 4,4), L-1);
  
        for j in 1:L-1

                #delh=randn(4)*pi/50;                    #Imperfection in Z tuning not included
                #int1=kron(RZ(delh[1]),RZ(delh[2]));
                int2=exp(-im*J*fonez-im*theta/2*(ftwox+ftwoy));
                #int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[j]=int2;

        end


        #############################################
        # Local Background Field      
        ##############################################


        for i in 1:2:L-1
                FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
        end





    A=brickwall(FU)   # Construct the matrix using brickwall function

    return A
end
;




function circuit_heisenberg(L, thetamean)
        Jmean=0.5*pi
        A=circuit_heisenberg(L, Jmean, thetamean)
        return A
end
  