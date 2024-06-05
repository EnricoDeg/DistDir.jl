const libdistdir = "libdistdir"
const libmpi = "libmpi"
libdistdir_handle = C_NULL
libmpi_handle = C_NULL

function __init__()
	libmpi_handle = Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
	libdistdir_handle = Libdl.dlopen(libdistdir, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

	println("libdistdir successfully opened !")
end