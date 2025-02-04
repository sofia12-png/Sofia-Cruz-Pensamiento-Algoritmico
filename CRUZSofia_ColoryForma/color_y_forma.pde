//COLOR Y FORMA
print("circulos libres");
size (520,520);
background(#FA4C3D);

// He creado dos variables X y Y para que manejar la posicion de los circulos sea mas facil
// Esto lo he tomado de la anterior vez que vi la clase
int x = 65;
int y = 70;

// noStroke porque no queremos bordes
noStroke();

// Primera fila de circulos, vamos a multiplicar el valor de x para crear copias
// con espacios iguales
fill(#0038FC);
ellipse(x,y,100,100);
ellipse(x*3,y,100,100);
ellipse(x*5,y,100,100);
ellipse(x*7,y,100,100);

// Segunda fila de circulos, cambiamos el color y aumentamos el valor de Y
fill(#2D5BFA);
ellipse(x,y+130,100,100);
ellipse(x*3,y+130,100,100);
ellipse(x*5,y+130,100,100);
ellipse(x*7,y+130,100,100);

// Tercera fila de circulos, a partir de aqui es mutiplicar el valor de 130 que se le suma a Y
fill(#FEFEFE);
ellipse(x,y+(130*2),100,100);
ellipse(x*3,y+(130*2),100,100);
fill(#FC6D0D);
ellipse(x*5,y+(130*2),100,100);
fill(#FEFEFE);
ellipse(x*7,y+(130*2),100,100);

// Ultima fila
fill(#2D5BFA);
ellipse(x,y+(130*3),100,100);
ellipse(x*3,y+(130*3),100,100);
ellipse(x*5,y+(130*3),100,100);
ellipse(x*7,y+(130*3),100,100);
