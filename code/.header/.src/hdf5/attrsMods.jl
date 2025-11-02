



function set_hdf5_attributes(file::HDF5.File)

    attrs = HDF5.attributes(file)
    
    ######################################
    # Attributes:
    ######################################
    
        # Extracting Date and Time
    
        Dates.now()
        attrs["1. Date/Time"] = string(Dates.now())
    
        # Author
        attrs["2. Author"] = "Sagnik Ghosh"
        
        # Device
	    attrs["3. Device"] = "LAPTOP-4QB76D20"
        #attrs["Cluster"] = "BAF"
    



        # Extracting Processor Type
    
        processor_type = Sys.CPU_NAME
        attrs["[ENV] 1. Processor Type"] = string(processor_type)
    
    
    
        # Extracting Julia Version
    
        julia_version = VERSION
        attrs["[ENV] 2. Julia Version"] = string(julia_version)
    
        # Modules
    
        module_list = Pkg.installed()
        attrs["[ENV] 3. Modules"] = string(module_list)
    
        # Code
    
        #script_content = read(path, String)
        #attrs["[ENV] 4. Code"] = script_content
    
    
        return nothing

        
end



function read_hdf5_attributes(file::HDF5.File)
    attrs = HDF5.attributes(file)
    for k in keys(attrs)
        println("$(k) => $(string(attrs["$k"][]))")
    end
end



function extract_metadata(file::HDF5.File, filename::String = "metadata.txt")
    attrs = HDF5.attributes(file)
    open(filename, "w") do io
        for k in keys(attrs)
            println(io, "$(k) => $(string(attrs["$k"][]))\n")
        end
    end
end
