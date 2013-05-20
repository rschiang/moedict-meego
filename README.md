moedict-meego
=============
A MeeGo Harmattan client port for [g0v.tw](http://dev.g0v.tw) moedict project.

![Screenshot of MoeDict MeeGo client on Nokia N9](docs/res/moedict-meego.png)

### Dependencies
* **Perl 5.14+** - required by [moedict-epub](https://github.com/g0v/moedict-epub)
* **Python 2.7+** - for building index (tested under 2.7.4)
* [Qt SDK](http://www.developer.nokia.com/Develop/Qt/Tools/) from Nokia - for N9 toolchain

### Building index

```
rschiang@RSChiang:~/moedict-meego$ make index
```
During the first run, `make source` is invoked. The build system will automatically fetch required 
repositories and generate mapped UTF-8 source file, which you can manually update by typing 
`make update source`.

The generated files are located at `data` folder.

### Current status

- [x] Basic UI
- [ ] Intergate ~~dictionary API~~ offline index first
- [ ] Progressive search and minor features
- [ ] Auto-update functionality

Join #g0v.tw discussion on Plurk or freenode IRC.
