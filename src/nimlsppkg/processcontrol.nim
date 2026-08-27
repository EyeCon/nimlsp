from std/os import osLastError, raiseOSError
from std/posix import SIGHUP, getpid, getppid, kill

when defined(linux):
  proc prctl(option: cint, arg2, arg3, arg4, arg5: culong): cint
    {.importc, header: "<sys/prctl.h>".}

# Make nimlsp die when its parent process dies.
# Fixes https://github.com/PMunch/nimlsp/issues/180 (at least for GNU/Linux).
template dieWithParent*(signal: cint = SIGHUP) =
  when defined(linux):
    block:
      # PR_SET_PDEATHSIG: request that the kernel deliver `signal`
      # to this process when its parent dies.
      const prSetPdeathsig = 1.cint
      let originalParent = getppid()
      if prctl(prSetPdeathsig, signal.culong, 0, 0, 0) != 0:
        raiseOSError(osLastError())
      # The parent may have died between getppid() and prctl().
      if getppid() != originalParent: discard kill(getpid(), signal)
