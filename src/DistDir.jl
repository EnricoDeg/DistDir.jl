module DistDir

using Libdl
using MPI

export initialize
export finalize
export distdir_exchanger
export distdir_verbose
export set_config_exchanger
export set_config_verbose

const libdistdir = "libdistdir"
const libmpi = "libmpi"
libdistdir_handle = C_NULL
libmpi_handle = C_NULL

@enum distdir_exchanger begin
	IsendIrecv1 = 0
	IsendIrecv2 = 1
	IsendRecv1 = 2
	IsendRecv2 = 3
	IsendIrecv1NoWait = 4
	IsendIrecv2NoWait = 5
	IsendRecv1NoWait = 6
	IsendRecv2NoWait = 7
end

@enum distdir_verbose begin
	verbose_true = 0
	verbose_false = 1
end

function initialize()
	@ccall libdistdir.distdir_initialize()::Cvoid
end

function finalize()
	@ccall libdistdir.distdir_finalize()::Cvoid
	Libdl.dlclose(libmpi_handle)
	Libdl.dlclose(libdistdir_handle)
	println("libdistdir successfully closed !")
end

function set_config_exchanger(exchanger_type::distdir_exchanger)
	@ccall libdistdir.set_config_exchanger(exchanger_type::Cint)::Cvoid
end

function set_config_verbose(verbose_type::distdir_verbose)
	@ccall libdistdir.set_config_verbose(verbose_type::Cint)::Cvoid
end

function new_group(new_comm :: MPI.Comm, work_comm :: MPI.Comm, id :: Int)
	@ccall libdistdir.new_group(new_comm :: Ref{MPI.Comm}, work_comm :: MPI.Comm, id :: Cint)::Cvoid
end

function __init__()
	libmpi_hamndle = Libdl.dlopen(libmpi, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)
	libdistdir_handle = Libdl.dlopen(libdistdir, Libdl.RTLD_LAZY | Libdl.RTLD_GLOBAL)

	println("libdistdir successfully opened !")
end

end
