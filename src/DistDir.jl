module DistDir

using Libdl

export initialize

const libdistdir = "libdistdir"
libdistdir_handle = C_NULL

function initialize()
	@ccall libdistdir.distdir_initialize()::Cvoid
end

function finalize()
	@ccall libdistdir.distdir_finalize()::Cvoid
	Libdl.dlclose(libdistdir_handle)
	println("libdistdir successfully closed !")
end

function __init__()
	libdistdir_handle = Libdl.dlopen(libdistdir, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

	println("libdistdir successfully opened !")
end

end
