import java.util.concurrent.locks.*;

class Ball {
  private float [] ponto_guardado; //x e y do ponto
  private float x, y, angle;
  private float v_linear; //velocidade
  private float v_angular; //angulo em radianos
  private boolean gotoPoint;
  private Lock l;

  Ball(float x, float y, float angle, float v, float d) {
    this.angle = angle;
    this.x = x;
    this.y = y;
    gotoPoint = false;
    ponto_guardado = new float[2];
    ponto_guardado[0] = -1; 
    ponto_guardado[1] = -1;
    this.v_linear = v;
    this.v_angular = d;
    l = new ReentrantLock();
  }

  public void setCoord(float x, float y, float angle) {
    l.lock();
    try {
      this.x = x; 
      this.y = y;
      this.angle = angle;
    }
    finally {
      l.unlock();
    }
  }

  public void setGotoPoint(boolean b) {
    l.lock();
    try {
      gotoPoint = b;
      float m = (ponto_guardado[1]-y)/(ponto_guardado[0]-x);
      PVector u = new PVector(cos(angle), sin(angle));
      PVector v = new PVector(ponto_guardado[0]-x, ponto_guardado[1]-y);
      float a = PVector.angleBetween(u,v);
      float sentido = (ponto_guardado[1]-y*cos(angle)) - (ponto_guardado[0]-x*sin(angle));
      if(sentido > 0) this.angle += a;
      else if(sentido < 0) this.angle -= a;
      v_angular = 0;
    }
    finally {
      l.unlock();
    }
  }


  public boolean getGotoPoint() {
    l.lock();
    try {
      return gotoPoint;
    }
    finally {
      l.unlock();
    }
  }

  public void setPoint() {
    l.lock();
    try {
      ponto_guardado[0] = x;
      ponto_guardado[1] = y;
    }
    finally {
      l.unlock();
    }
  }

  public float[] getPoint() {
    l.lock();
    try {
      return ponto_guardado;
    }
    finally {
      l.unlock();
    }
  }

  public void setVD(float v_linear, float v_angular) {
    l.lock();
    try {
      this.v_linear = v_linear;
      this.v_angular = v_angular;
    }
    finally {
      l.unlock();
    }
  }

  public float[] getAttributes() {
    float[] a = new float[5];
    l.lock();
    try {
      a[0] = v_linear;
      a[1] = v_angular;
      a[2] = x; 
      a[3] = y;
      a[4] = angle;
      return a;
    }
    finally {
      l.unlock();
    }
  }
}