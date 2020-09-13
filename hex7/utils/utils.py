from buildbot.plugins import *

def get_change_source(repo, branch, poll):
  return changes.GitPoller('https://github.com/nand0p/' + repo + '/covid19.git',
                           workdir=repo + '-workdir',
                           branch=branch,
                           pollInterval=poll)
