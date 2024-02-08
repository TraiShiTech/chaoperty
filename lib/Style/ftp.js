// ftp.js
function connectToFtp(host, user, password, port) {
   // Your FTP connection logic here
   const ftpConnection = {
       currentDirectory: '/',
       setDirectory: function (directory) {
           this.currentDirectory = directory;
           console.log('Setting current directory to:', this.currentDirectory);
       }
   };
   return ftpConnection;
}
