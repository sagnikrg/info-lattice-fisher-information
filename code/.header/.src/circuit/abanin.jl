
#################################
# The proposed Floquet Unitary
# from PRL 114, 140401 (2015)
#
# Abanin et. al.
#################################





#################################
# Dependencies
#################################

include("brickwall.jl")



 ###########################################
 #The Brickwall 
 #
 ###########################################



function brickwall_abanin(L::Int, thetamean::Float64, h::Array{Float64}, J::Array{Float64})
  
    
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


        #thetadev=pi/50;
        theta=thetamean#+randn(1)[]*thetadev;                # Interaction + tuning noise commented for now
                                  
        #############################################
        # Defining two body gates as array of Tensors        
        ##############################################
  
        FU=fill(fill(0.0*im, 4,4), L-1);
  
        for j in 1:L-1

                #delh=randn(4)*pi/50;                        # Imperfection in Z tuning
                #int1=kron(RZ(delh[1]),RZ(delh[2]));
                int1=exp(-im*J[j]*fonez);
                int2=exp(-im*theta*(ftwox+ftwoy));           # Note difference of a factor 1/2 than DTC ckt!   
                #int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[j]=int1*int2;                             # Note the order is reveresed here

        end


        #############################################
        # Local Background Field      
        ##############################################


        for i in 1:2:L-1
                FU[i]=kron(ZRow[i],ZRow[i+1])*FU[i];         # Note the order is reveresed here
        end


        # No kick ofc!

        # Returning brickwall:

        return FU
end
;



 ###########################################
 #The circuit (As a Matrix)
 #
 ###########################################






function circuit_abanin(L::Int, thetamean::Float64, h::Array{Float64}, J::Array{Float64})

    FU=brickwall_abanin(L, thetamean, h, J)
    A=brickwall(FU)   # Construct the matrix using brickwall function
    return A
end
;






################################
# Multiple Dispatch variations:
#################################


# The parameters of the paper:

function circuit_abanin(L,thetamean)
  
    

 #########################################
 # Background Disorder for the Z field
 #########################################

        h=rand(L).*5 .- 2.5;
        J=fill(0.25, L);                   # Uniform J

        thetamean=thetamean/4              # To be consistent with the parameters in the paper

        A=circuit_abanin(L,thetamean, h, J)   # Construct the matrix using brickwall function

    return A
end
;



