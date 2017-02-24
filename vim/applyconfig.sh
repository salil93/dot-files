#Take a backup of the existing vim config

echo 'Taking backup of existing vim configurations'
if [ -d ~/.vim ]; then
	echo 'Backing up .vim folder'
	mv ~/.vim ~/.vim.bak
fi
if [ -e ~/.vimrc ]; then
	echo 'Backing up .vimrc file'
	mv ~/.vimrc ~/.vimrc.bak
fi

echo 'Applying new vim configuration'

cp -r ./vim ~/.vim
cp ./vimrc ~/.vimrc

echo 'Vim configuration applied'
