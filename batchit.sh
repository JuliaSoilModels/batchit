#!/bin/bash 

currdir=$(pwd)
commit="$(git rev-parse --short HEAD)"
dir="$(git ls-files --full-name $1)"
scriptname=${1%.*}
datetime=$(date +%Y-%m-%d/%H-%M)
branchname="jobs/$datetime-$scriptname"
worktree="/Net/Groups/BGI/scratch/SSPL/worktrees/$branchname"
git checkout -b $branchname
git worktree add $worktree
cd $worktree
cd "$(dirname $dir)"

cat >clean.sh <<EOL
#!/bin/bash
#SBATCH --job-name=job-cleaner
#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=00:00:30
#SBATCH -o /dev/null
#SBATCH --nodes=1

cd $currdir
git worktree remove $worktree
EOL

JOBID=$(sbatch --parsable $1)
echo "Job $JOBID submitted for script $1 in worktree: $worktree"
sbatch --dependency=afterok:$JOBID clean.sh
