

#################################
# Dependencies
#################################

include("brickwall.jl")





######################
# This code generates Unitary Brickwall circuit corresponding to the heisenberg model;
# Form: H = J ZZ +  θ/2 (XX+YY) + h Z
# h is always disordered and uniformly sampled from [0, 2pi] 
#
# J has two options: One can use a uniform J=Jmean or sample J uniformly from [0, pi]
# (See ###Coefficient of ZZ)
#
# Jmean is traded as in input for J, the Multiple Dispatch wrappers automatically 
# takes care of including the correct Coefficient. 
#
#
# options for including various noise models is coded and commented out
#
# The Skeleton function
#######################








 ###########################################
 #The Brickwall 
 #
 ###########################################



function brickwall_heisenberg(L::Int, thetamean::Float64, h::Array{Float64}, J::Array{Float64})

###########################################    
# Defining the indices
###########################################

        Ind=collect(1:L)
 #########################################
 # Background Disorder for the Z field
 #########################################
        ZRow=RZ.(h);


 ###########################################
 #Constructing the Random Brickwall 
 ###########################################

        #Coefficient of ZZ        
        # Old lists obsolete, its handled directly as an input;
        
        
        #Interaction
        
        
        #thetadev=pi/50;
        theta=thetamean #+randn(1)[]*thetadev;                          # To include tuning noise uncomment
        
        #For the two body XX+YY gates:

        fonez=copy(kron(Z,Z))
        ftwox=copy(kron(X,X));                  
        ftwoy=copy(kron(Y,Y));

        #############################################
        # Defining two body gates as array of Tensors        
        ##############################################
  
        FU=fill(fill(0.0*im, 4,4), L-1);
  
        for i in 1:L-1

                #delh=randn(4)*pi/50;                                   #To include imperfection noise uncomment 
                #int1=kron(RZ(delh[1]),RZ(delh[2]));
                int2=exp(-im*J[i]*fonez-im*theta/2*(ftwox+ftwoy));
                #int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[i]=int2;

        end


        #############################################
        # Local Background Field      
        ##############################################


        for i in 1:2:L-1
                FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
        end


        return FU
end






 ###########################################
 #The circuit (As a Matrix)
 #
 ###########################################




function circuit_heisenberg(L::Int, thetamean::Float64, h::Array{Float64}, J::Array{Float64})

    FU=brickwall_heisenberg(L, thetamean, h, J)
    A=brickwall(FU)   # Construct the matrix using brickwall function
    
    #return FU
    return A

end
;






################################
# Multiple Dispatch variations:
#################################


# implicitly drawing Background Disorder h

function circuit_heisenberg(L::Int, thetamean::Float64, J::Array{Float64})
 
 
        # Background Disorder for the Z field
 
        h=rand(L)*2*pi;
        

        A=circuit_heisenberg(L, thetamean, h, J)
        return A
end


# implicitly drawing Disorder on J


function circuit_heisenberg(L::Int, thetamean::Float64)
        
        J=rand(L-1)*pi;   
        h=rand(L)*2*pi;
        

        A=circuit_heisenberg(L, thetamean, h, J)
        return A
end
  

# implicitly drawing uniform J


function circuit_heisenberg(L::Int, thetamean::Float64, Jmean::Float64)
        
        J=fill(Jmean, (L-1));   
        h=rand(L)*2*pi;
        

        A=circuit_heisenberg(L, thetamean, h, J)
        return A
end
  