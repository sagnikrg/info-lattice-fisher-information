

#################################
# Dependencies
#################################

include("brickwall.jl")









 ###########################################
 #The Brickwall 
 #
 ###########################################



function brickwall_dtc(L::Int, thetamean::Float64, epsilon::Float64, h::Array{Float64}, J::Array{Float64})
  
    
###########################################    
# Defining the indices
###########################################

        Ind=collect(1:L)

 #########################################
 # Creating the Disorder for the Z field
 #########################################

        ZRow=RZ.(h);


 ###########################################
 #Constructing the Random Brickwall 
 ###########################################

                  

        fonez=copy(kron(Z,Z))     #Ising Even Disorder on the two body gates through array J  
        ftwox=copy(kron(X,X));    #For the two body XX+YY gates
        ftwoy=copy(kron(Y,Y));


        thetadev=pi/50;
        theta=thetamean+randn(1)[]*thetadev;                # Interaction + tuning noise
                                  
        #############################################
        # Defining two body gates as array of Tensors        
        ##############################################
  
        FU=fill(fill(0.0*im, 4,4), L-1);
  
        for j in 1:L-1

                delh=randn(4)*pi/50;                        # Imperfection in Z tuning
                int1=kron(RZ(delh[1]),RZ(delh[2]));
                int2=exp(-im*J[j]*fonez-im*theta/2*(ftwox+ftwoy));
                int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[j]=int3*int2*int1;

        end


        #############################################
        # Local Background Field      
        ##############################################


        for i in 1:2:L-1
                FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
        end




        ###########################################
        #Constructing the X Kicks 
        ##########################################


        g=pi*(1-epsilon);
       
    
        for i in 2:2:L-1
                FU[i]=kron(RX(g),RX(g))*FU[i];
        end

            ############################################        
            # Open Boundary Condition:
            ############################################

            FU[1]=kron(RX(g),I(2))*FU[1];
            FU[end]=kron(I(2),RX(g))*FU[end];



     return FU
end
;



 ###########################################
 #The circuit (As a Matrix)
 #
 ###########################################






function circuit_dtc(L::Int, thetamean::Float64, epsilon::Float64, h::Array{Float64}, J::Array{Float64})

    FU=brickwall_dtc(L, thetamean, epsilon, h, J)
    A=brickwall(FU)   # Construct the matrix using brickwall function
    return A
end
;






################################
# Multiple Dispatch variations:
#################################


# implicitly drawing Background Disorders h, J

function circuit_dtc(L,thetamean,epsilon)
  
    

 #########################################
 # Background Disorder for the Z field
 #########################################

        h=rand(L)*2*pi;
        J=rand(L)*pi;             #Ising Even Disorder on the two body gates




    A=circuit_dtc(L,thetamean,epsilon, h, J)   # Construct the matrix using brickwall function

    return A
end
;





##################################
#
# Other functions
#
##################################


function kick(L,epsilon)
    g=pi*(1-epsilon);
    XRow=copy(kron_power(RX(g),L));
    XRow

end



function parity(L)
    
    ZRow=copy(kron_power(Z,L));
    ZRow

end