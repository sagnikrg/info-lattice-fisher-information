

#Global Header File

using LinearAlgebra             #   Linear Algebra 
#using MKL                       #   MKL
#using Random                     #   Random RandomMatrices
#using HDF5                      #   For HDF5
#using CairoMakie                #   For Plotting
#using FFTW                      #   For FFT 
#using StatsBase
#using Kronecker

#using Arpack
#using ITensors
#using ITensorMPS
#using ITensorsVisualization     #   Packages for ITensors
#using BenchmarkTools

#include("gates.jl")
#include("brickwall.jl")
#include("plotMods.jl")
#include("functions.jl")


include(".src/gates/gates.jl")
include(".src/functions/kron.jl")

