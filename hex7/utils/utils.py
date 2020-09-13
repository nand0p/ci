from buildbot.plugins import *


def get_change_source(repo, branch, poll):
  workdir = repo + '-workdir'
  return changes.GitPoller('https://github.com/nand0p/' + repo + '.git',
                           workdir=workdir,
                           branch=branch,
                           pollInterval=poll)


def get_branch_scheduler(name, branch):
  return schedulers.SingleBranchScheduler(name=name,
                                          change_filter=util.ChangeFilter(branch=branch),
                                          treeStableTimer=None,
                                          builderNames=[name])


def get_force_scheduler(name):
  scheduler_name = 'force-' + name
  return schedulers.ForceScheduler(name=scheduler_name,
                                   builderNames=[name])


def get_nightly_scheduler(name, branch, hour, minute):
  scheduler_name = 'nightly-' + name
  return schedulers.Nightly(name=scheduler_name,
                            branch=branch,
                            builderNames=[name],
                            hour=hour,
                            minute=minute)
