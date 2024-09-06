Script to run slurm batch scripts;

+ Creates a branch on current commit
+ creates a worktree in /Net/.../scratch/SSPL/worktrees based on the branch
+ Creates a cleanup slurm batch script to delete the worktree after the main job is done, 
+ sbatch the script
+ sbatch the cleanup script with the main script as its dependency
