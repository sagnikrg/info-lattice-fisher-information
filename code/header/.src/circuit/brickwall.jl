using ITensors
ITensors.disable_warn_order()


# dependencies

include("../gates/gates.jl")
include("../functions/kron.jl")


########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 

function brickwall(L,thetamean,epsilon)
  
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
#check header

########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 


########################################################

# The Brickwall as a Tensor Function
# format

# |     |     |     |     |     |     |     |  
#---------------------------------------------
#       |  2  |     |  4  |     |  6  |         
#---------------------------------------------
# |  1  |     |  3  |     |  5  |     |  7  |
#---------------------------------------------
# |     |     |     |     |     |     |     |

########################################################


function brickwall_tensor(L,thetamean,epsilon)

 #########################################
 # Background Disorder for the Z field
 #########################################

   h=rand(L)*2pi;              
   ZRow=RZ.(h);


 ###########################################
 #Constructing the Random Brickwall 
 ###########################################

        J=rand(L)*pi;             #Ising Even Disorder on the two body gates

        fonez=copy(kron(Z,Z))
        ftwox=copy(kron(X,X));  #For the two body XX+YY gates
        ftwoy=copy(kron(Y,Y));


        thetadev=pi/50;
        theta=thetamean+randn(1)[]*thetadev;  #Interaction
                                  
    FU=fill(fill(0.0*im, 4,4), L-1);
    FUTensor=fill(fill(0.0*im, 2,2,2,2), L-1);

    for j in 1:length(FU)
    
            delh=randn(4)*pi/50;         #Imperfection in Z tuning
            int1=kron(RZ(delh[1]),RZ(delh[2]));
            int2=exp(-im*J[j]*fonez-im*theta/2*(ftwox+ftwoy));
            int3=kron(RZ(delh[3]),RZ(delh[4]));

            FU[j]=int2;
    end

 ##########################################
 #Constructing the X Kicks 
 ##########################################


    g=pi*(1-epsilon);



 #############################################
 # Defining two body gates as array of Tensors        
 ##############################################


 #   for i in 1:2:L-1
  #      FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
  #      FUTensor[i]=reshape(Int,2,2,2,2)
  #  end

    for i in 2:2:L-1
        FU[i]=kron(RX(g),RX(g))*FU[i];
        #FUTensor[i]=reshape(Int,2,2,2,2)
    end

 ############################################        
 # Open Boundary Condition:
 ############################################

 FU[1]=kron(RX(g),I(2))*FU[1];
 FU[L-1]=kron(I(2),RX(g))*FU[L-1];


 for i in 1:2:L-1
    FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
    FUTensor[i]=reshape(FU[i],2,2,2,2)
end

for i in 2:2:L-1
    #FU[i]=kron(RX(g),RX(g))*FU[i];
    FUTensor[i]=reshape(FU[i],2,2,2,2)
end
 # Returning Brickwall:        
 FUTensor

end
;



function brickwall_bare(L,thetamean)
  
    #Constructing the background Z field
    
        h=rand(L)*pi/2;
        Ind=collect(1:L)
        ZRow=copy(kron_list(RZ.(h),Ind));

 
        #Constructing the Random Brickwall 


            J=rand(L)*pi/2;                     #Ising Even Disorder on the two body gates

            fonez=copy(kron(Z,Z))               #
            ftwox=copy(kron(X,X));              #For the two body XX+YY gates
            ftwoy=copy(kron(Y,Y));              #

    
            thetadev=pi/50;
            theta=thetamean#+randn(1)[]*thetadev;               #Interaction
                                      
            delh=randn(4)*pi/50;                                          #Imperfection in Z tuning

        FU=fill(fill(0.1+im, 4,4), L);


        for j in 1:length(FU)
        
            #int1=kron(RZ(delh[1]),RZ(delh[2]));
                int2=exp(-im*J[j]*fonez-im*theta/2*(ftwox+ftwoy));
             #   int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[j]=int2;
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
            



          A=UEven*UOdd*ZRow;
          

 A    
end
;

function kick(L,epsilon)
    g=pi*(1-epsilon);
    XRow=copy(kron_power(RX(g),L));
    XRow

end

function parity(L)
    
    ZRow=copy(kron_power(Z,L));
    ZRow

end

    ########################################
    # time evolution with ITensor
    ########################################



    
function itensorise(FUTensor, sites, dummysites)
    L=length(FUTensor);
    gates = ITensor[]
    for i in 1:2:L
        push!(gates, ITensor(FUTensor[i],dummysites[i+1],dummysites[i],sites[i+1],sites[i]))
    end
  

    for i in 2:2:L
        push!(gates, ITensor(FUTensor[i],sites[i+1],sites[i],dummysites[i+1],dummysites[i]))
        end
  
    gates
end


##################################
# Note in this case the order of the gates in brick has changed.
# Unlike tev_1 case we first put all the odd gates and then the even gates.
# This has to be accounted appropriately in the tev function.
##################################

function brickwall_tev(Psi, brick, sites, dummysites)

    L=length(brick)
    Lhalf=Int((L+1)/2)
    for i in 1:Lhalf
        Psi=brick[i]*Psi
    end

    #for i in 1:L+1
    #    Psi=Psi*delta(sites[i],dummysites[i])
    #end

    #order_dummy = (dummysites[1],dummysites[2],dummysites[3],dummysites[4],dummysites[5],dummysites[6],dummysites[7],dummysites[8])
    #Psi=permute(Psi, order_dummy)

    for i in (Lhalf+1):L
        Psi=brick[i]*Psi
    end
    
    #for i in 2:L
        Psi=Psi*delta(sites[1],dummysites[1])
        Psi=Psi*delta(sites[L+1],dummysites[L+1])
    #end
    
    #order = (sites[8],sites[7],sites[6],sites[5],sites[4],sites[3],sites[2],sites[1])
    #Psi=permute(Psi, order)
   
    # psi=apply(brick[1:2:L-1], psi);  # Apply the odd gates
   # psi=apply(brick[2:2:L-1], psi);  # Apply the even gates
    Psi
end





function EntanglementEntropy(eigvec, l)

    lhalf=Int(l/2)
    
    eigreshape=reshape(eigvec,2^lhalf,2^lhalf)
    
    U,S,V=svd(eigreshape)
    
    ee=0.0
    
    for i in 1:2^lhalf
        if S[i]>1e-10
        ee=ee+-S[i]^2*log(S[i]^2)
        end
    end
    
    return ee
    
end
    
