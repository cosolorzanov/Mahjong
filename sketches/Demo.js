/**
 Demo
 by Carlos Orlando Solórzano.

 This sketch implements the following scene-graph:

 World
 ^
 |\
 | \
 L1 L5
 ^   ^
 |    \
 |     \
 L2     L6
 ^
 |
 |
 L3
 ^
 |
 |
 L4
 */

var sketch = function( p ) {
    var canvas1;

    //base params
    var transBaseX=600;
    var transBaseY=300;
    var transVolquetaX=50;
    var transVolquetaY=210;
    var rotarBase=0;
    var rotarVolqueta=0;
    var rotarPalanca1=0.7;
    var rotarPalanca2=-1.4;
    var rotarPala=0.3;
    var rotarPlaton=0;
    var escala=1;
    var maquina=true;

    p.setup = function() {
        p.createCanvas(800, 500);
        p.frameRate(15);
        canvas1 = p.createGraphics(p.width, p.height);
    };

    p.draw = function(){
        //p.background(0);
        canvas1.background(50);
        // call scene off-screen rendering on canvas 1
        scene(canvas1);
        // draw canvas onto screen
        p.image(canvas1, 0, 0);

        if(p.keyIsDown(187))
            escala += 0.1;
        if(p.keyIsDown(189))
            escala -= 0.1;
        if(p.keyIsDown(67))
            maquina = !maquina;

        if(p.keyIsDown(81) && maquina)
            transBaseX -= 5;
        if(p.keyIsDown(69) && maquina)
            transBaseX += 5;
        if(p.keyIsDown(50) && maquina)
            transBaseY -= 5;
        if(p.keyIsDown(87) && maquina)
            transBaseY += 5;
        if(p.keyIsDown(65) && maquina)
            rotarBase -= 0.05;
        if(p.keyIsDown(68) && maquina)
            rotarBase += 0.05;
        if(p.keyIsDown(52) && maquina && rotarPalanca1<=1.4)
            rotarPalanca1 += 0.1;
        if(p.keyIsDown(82) && maquina && rotarPalanca1>=-0.5)
            rotarPalanca1 -= 0.1;
        if(p.keyIsDown(53) && maquina && rotarPalanca2<=0)
            rotarPalanca2 += 0.1;
        if(p.keyIsDown(84) && maquina && rotarPalanca2>=-2.5)
            rotarPalanca2 -= 0.1;
        if(p.keyIsDown(54) && maquina && rotarPala<=3.2)
            rotarPala += 0.1;
        if(p.keyIsDown(89) && maquina && rotarPala>=0)
            rotarPala -= 0.1;

        if(p.keyIsDown(65) && !maquina)
            rotarVolqueta -= 0.05;
        if(p.keyIsDown(68) && !maquina)
            rotarVolqueta += 0.05;
        if(p.keyIsDown(81) && !maquina)
            transVolquetaX -= 5;
        if(p.keyIsDown(69) && !maquina)
            transVolquetaX += 5;
        if(p.keyIsDown(50) && !maquina)
            transVolquetaY -= 5;
        if(p.keyIsDown(87) && !maquina)
            transVolquetaY += 5;
        if(p.keyIsDown(56) && !maquina && rotarPlaton<0.5)
            rotarPlaton += 0.05;
        if(p.keyIsDown(73) && !maquina && rotarPlaton>=0.05)
            rotarPlaton -= 0.05;
    };

    function scene(pg) {

        if(maquina){
            pg.textSize(32);
            pg.fill(0, 102, 153);
            pg.text("Retroexcavadora seleccionada", 20, 40);
        }
        else {
            pg.textSize(32);
            pg.fill(0, 102, 153);
            pg.text("Volqueta seleccionada", 20, 40);
        }

        // define a local frame L1 (respect to the world)

        pg.push();
        pg.translate(transBaseX,transBaseY);
        pg.rotate(rotarBase);
        pg.scale(escala,escala);
        retro(pg);

        pg.translate(20,-45);
        // dibuja la palanca 1 en  L2
        pg.push();
        pg.rotate(rotarPalanca1);
        palanca1(pg);

        pg.translate(-110,0);
        // dibuja la palanca 2 en  L3
        pg.push();
        pg.rotate(rotarPalanca2);
        palanca2(pg);

        pg.translate(-110,0);
        // dibuja el balde en  L4
        pg.push();
        pg.rotate(rotarPala);
        balde(pg);
        //return to L3
        pg.pop();
        //return to L2
        pg.pop();
        //return to L1
        pg.pop();
        //return to world
        pg.pop();

        // define a local frame L5 (respect to the world)
        pg.push();
        pg.translate(transVolquetaX,transVolquetaY);
        pg.rotate(rotarVolqueta);
        pg.scale(escala,escala);
        volqueta(pg);

        pg.translate(230,0);
        //dibuja el platon de la volqueta en L6
        pg.push();
        pg.rotate(rotarPlaton);
        platon(pg);
        //return to L5
        pg.pop();
        //return to world
        pg.pop();
    };

    function retro(pg) {
        pg.push();
        pg.stroke(0);
        pg.fill(0);
        pg.rect(0,0,120,30);
        pg.ellipse(0,15,30,30);
        pg.ellipse(120,15,30,30);
        pg.fill(255,69,0);
        pg.rect(40,-10,40,10);
        pg.fill(255,215,0);
        pg.rect(10,-30,100,20);
        pg.rect(30,-70,80,40);
        pg.noStroke();
        pg.ellipse(70,-70,78,20);
        pg.fill(240,248,255);
        pg.rect(45,-65,35,35);
        pg.pop();
    };

    function palanca1(pg){
        pg.push();
        pg.stroke(0);
        pg.fill(255,215,0);
        pg.rect(0,-10,-120,20);
        pg.fill(255,69,0);
        pg.ellipse(0,0,30,30);
        pg.ellipse(-110,0,30,30);
        pg.pop();
    };

    function palanca2(pg){
        pg.push();
        pg.stroke(0);
        pg.fill(255,215,0);
        pg.rect(0,-10,-120,15);
        pg.fill(255,69,0);
        pg.ellipse(0,0,30,30);
        pg.ellipse(-110,0,30,30);
        pg.pop();
    };

    function balde(pg) {
        pg.push();
        pg.stroke(0);
        pg.fill(255,215,0);
        pg.arc(20,20,55,55,0,pg.PI+pg.QUARTER_PI,pg.PIE);
        pg.noStroke();
        pg.ellipse(30,30,20,25);
        pg.fill(255,69,0);
        pg.stroke(0);
        pg.ellipse(0,0,30,30);
        pg.pop();
    }
    function volqueta(pg) {
        pg.push();
        pg.fill(0);
        pg.stroke(0);
        pg.rect(0,0,230,30);
        pg.fill(100,100,100);
        pg.rect(0,30,230,10);
        pg.rect(0,10,40,20);
        pg.fill(141,73,39);
        pg.arc(40, 40, 62, 62, pg.PI,0, pg.OPEN);
        pg.fill(0);
        pg.ellipse(40,40,55,55);
        pg.fill(220,220,220);
        pg.ellipse(40,40,30,30);
        pg.fill(100,100,100);
        pg.ellipse(40,40,10,10);
        pg.fill(141,73,39);
        pg.arc(130, 40, 62, 62, pg.PI,0, pg.OPEN);
        pg.fill(0);
        pg.ellipse(130,40,55,55);
        pg.fill(220,220,220);
        pg.ellipse(130,40,30,30);
        pg.fill(100);
        pg.ellipse(130,40,10,10);
        pg.fill(141,73,39);
        pg.arc(190, 40, 62, 62, pg.PI,0, pg.OPEN);
        pg.fill(0);
        pg.ellipse(190,40,55,55);
        pg.fill(220,220,220);
        pg.ellipse(190,40,30,30);
        pg.fill(100);
        pg.ellipse(190,40,10,10);

        pg.fill(141,73,39);
        pg.quad(0,0,20,-70,80,-70,80,0);
        pg.fill(240,255,255);
        pg.quad(23,-30,30,-60,70,-60,70,-30);
        pg.noStroke();
        pg.fill(141,73,39);
        pg.rect(90,-20,30,20);
        pg.translate(90,-20);
        pg.rotate(0.8);
        pg.rect(0,0,15,-80);
        pg.pop();
    }

    function platon(pg) {
        pg.push();
        pg.noStroke();
        pg.fill(173,104,47);
        pg.quad(0,0,-130,-10, -150, -80,0,-80);
        pg.rect(-150,-95, 15,15);
        pg.pop();
    }
};

var p5_mm = new p5(sketch, 'Demo_id');
