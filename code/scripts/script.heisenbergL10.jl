#########################
# Include Headers
#########################

using LinearAlgebra
using HDF5
using Arpack

#using CairoMakie

include("../.header/.src/circuit/brickwall.jl")
include("../.header/.src/circuit/heisenberg.jl")
include("../.header/.src/circuit/time_crystals.jl")
include("../.header/.src/hdf5/hdf5_mods.jl")
#include("../header/.src/plotmods/colorschemes_mods.jl")
#include("../header/.src/random_matrices/random_matrices.jl")
#include("../header/.src/measurements/projectors.jl")
include("../.header/.src/info_lattice/info_lattice.jl")
include("../.header/.src/lazadires_diagram/lazadires_diagram.jl")
include("../.header/.src/functions/histgram.jl")
include("../.header/.src/eigen_statistics/eigen_statistics.jl")






#### attrs-author-and-generating-file for given L

# parameters

L=10
N=2^L
N_band=N

Itrnumb=100

global thetalist=[collect(0.0:0.025:0.525); collect(0.6:0.05:1.6)]
global epsilon=0.5    


dest_file_name="../data/hiesenberg_transition_ordpar_L$(L).hdf5"


#################################
# Script:
#################################



#### attrs-baf

global file=h5open(dest_file_name,"cw")


set_hdf5_attributes_baf(file)

close(file)





#### attrs-METADATA

 file=h5open(dest_file_name,"cw")

 attrs = HDF5.attributes(file)

 attrs["4. METADATA"]=["This file contains raw eigen data and information lattice of individual eigenstates of the XXZ unitary, we aim to establish the critical point of the ETH-MBL transition with the aim to establish the unitary as a candidate driving scheme for the fisher information based probe for measurment induced phase transition as proposed by Arnau, Silvia and Xhek.
 
 We save the realistion of h, J for each realisation and since this is the only source of random-ness, results can be exactly reproduced. Relevant functions used to generate the circuit will be provided as a script. info-lattice Data for various projected eigenstates to be added in a seperate file. We also record benchmark times for the Arpack.eigen() and computation of info_lattice seperately. The phase-space scan is run after running a pre-compilation. benchmarktime for pre-compilation is also provided for reference."]



close(file)




#### attrs-model

file=h5open(dest_file_name,"cw")

 attrs = HDF5.attributes(file)

 attrs["[Model] 1. Unitary"]="exp(- i g X)*exp(- i J_i ZZ + \theta/2 (XX+YY))exp(- i h_i Z)"

 attrs["[Model] 2. L"]=L

 attrs["[Model] 3. Tuning parameter"]="theta"
 
 attrs["[Model] 4. Range of J"]="[1.0], Uniform"

 attrs["[Model] 5. Range of h"]="[0, 2pi], Uniform Sampling"

 attrs["[Model] 6. Order parameters"]="eigenvalues"#, info_lattice"
 
 attrs["[Model] 7. Range of theta"]= thetalist

 g=1-epsilon
 
 attrs["[Model] 8. g"]= g

 attrs["[Model] 8. Itrnumb"] = Itrnumb

 #attrs["[Model] 9. Band Size for Info Lattice"] = N_band

close(file)



##########################################
# benchmark compile() step
##########################################


thetatry=0.4 
               # rougly at the critical state
A=circuit_dtc(L, thetatry, epsilon)


  file=h5open(dest_file_name,"cw")


# benchmarking eigen

Bnch_T1_eig=Dates.now()
    eigvals,eigvecs= eigen(A)
Bnch_T2_eig=Dates.now()

file["L$(L)/compile/benchmark_time/eigen"]=string(Bnch_T2_eig-Bnch_T1_eig)



# sorting the eigenvalues to get a patch:

#eigvals,eigvecs =phase_ordered_eigvecs(eigvals,eigvecs)

# benchmarking info_lattice

#Bnch_T1_ilat=Dates.now()
#        for i in 1:N_band
#                state=eigvecs[i,:]
#                info_lattice_state=info_lattice(state)
#        end
#Bnch_T2_ilat=Dates.now()

#file["L$(L)/compile/benchmark_time/info_lattice"]=string(Bnch_T2_ilat-Bnch_T1_ilat)

close(file)




##################################################################
# Script for collecting eigen-data
##################################################################

  
  for itr in 1:Itrnumb
  
        for theta in thetalist

        
        global file=h5open(dest_file_name,"cw")

        ## Drawing the Disorders

        
        J=fill(1.0 ,(L-1));
        h=rand(L)*2*pi;
        


        ## Writing the disorder strengths

        file["L$(L)/theta$(theta)/Itr$(itr)/h"]=h;
        file["L$(L)/theta$(theta)/Itr$(itr)/J"]=J;

        
        ## Building Ckt

        local A=circuit_dtc(L,theta, epsilon,h,J)


        ## ED

        local Bnch_T1_eig=Dates.now()
        local        eigvals,eigvecs= eigen(A)
        local Bnch_T2_eig=Dates.now()

        
        # sorting the eigenvalues to get a patch:

#        eigvals,eigvecs =phase_ordered_eigvecs(eigvals,eigvecs)


        ## Writing eigenvalues, benchmark_time

#        file["L$(L)/theta$(theta)/Itr$(itr)/eigvals"]=eigvals;
#        file["L$(L)/theta$(theta)/Itr$(itr)/benchmark_time/eigen"]=string(Bnch_T2_eig-Bnch_T1_eig)



        ## Writing info-lattice of individual eigenstates, and total benchmark_time

       
       
#        local Bnch_T1_ilat=Dates.now()

#        for i in 1:N_band
#                state=eigvecs[i,:]
#                info_lattice_state=info_lattice(state)
#                file["L$(L)/theta$(theta)/Itr$(itr)/info_lattice/eigvec_$(i)"]=lattice_to_vec(info_lattice(state))
#        end

#        local Bnch_T2_ilat=Dates.now()

        
        
#        file["L$(L)/theta$(theta)/Itr$(itr)/benchmark_time/info_lattice"]=string(Bnch_T2_ilat-Bnch_T1_ilat)


        close(file)

        end
        print("$(itr) \n")
        GC.gc()
end