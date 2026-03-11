# functions to automatically update entries in HDF5 files;


function hdf5_update_entry(file_path::String, data_path::String, data_array)

    file=h5open(file_path, "cw")

    array_new=file[data_path][:];
    array_updated=vcat(array_new, data_array);
    delete_object(file, data_path);
    file[data_path]=array_updated;

    close(file);

    return nothing;
end



function hdf5_update_entry(file_in::String, path_in::String, file_data::String, path_data::String)

    file_data=h5open(file_data, "r");


    data_array=file_data[path_data][:];
    hdf5_update_entry(file_in, path_in, data_array);

    close(file_data);
    return nothing;
end