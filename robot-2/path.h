
class Astar {
  public:
  void Astar(int width, int height, int**maze){
    initarray(width, height, closed);
  }

  int** initarray(int h, int w, int** a){
    a = new int *[h];
    for(int i=0; i < h; i++){
      a[i] = new int[w];
    }
    return a;
  }

  void findPath(int start, int stop){
    ;
  }

  private:
  int width;
  int height;
  int ** closed;
}

