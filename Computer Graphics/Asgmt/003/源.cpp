#include <GL/glut.h>    
#include <stdio.h>    
#include <Windows.h>    
#include <stdlib.h>    
#include <math.h>

// Basic cube information
void cube_info()
{
	// Drawing coordinate
	glBegin(GL_LINES);
	glPointSize(8);
	glLineWidth(2);
	glColor3f(1, 1, 1);
	glVertex3f(0, -1, 0);
	glVertex3f(0, 1, 0);
	glVertex3f(-1, 0, 0);
	glVertex3f(1, 0, 0);
	glVertex3f(0, 0, -1);
	glVertex3f(0, 0, 1);
	glEnd();

	// Drawing Cubes
	glBegin(GL_LINES);
	glPointSize(8);
	glLineWidth(2);
	glVertex3f(0.5, 0.5, -0.5);
	glVertex3f(-0.5, 0.5, -0.5);
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(0.5, 0.5, 0.5);
	glVertex3f(0.5, -0.5, 0.5);
	glVertex3f(-0.5, -0.5, 0.5);
	glVertex3f(-0.5, -0.5, -0.5);
	glVertex3f(0.5, -0.5, -0.5);
	glEnd();

	// Fill in color
	glBegin(GL_QUADS);
	glColor3f(0.0, 0.0, 1.0);
	glVertex3f(0.5, 0.5, -0.5);
	glVertex3f(-0.5, 0.5, -0.5);
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(0.5, 0.5, 0.5);

	glColor3f(0.0, 1.0, 0.0);
	glVertex3f(0.5, -0.5, 0.5);
	glVertex3f(-0.5, -0.5, 0.5);
	glVertex3f(-0.5, -0.5, -0.5);
	glVertex3f(0.5, -0.5, -0.5);

	glColor3f(1.0, 0.0, 0.0);
	glVertex3f(0.5, 0.5, 0.5);
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(-0.5, -0.5, 0.5);
	glVertex3f(0.5, -0.5, 0.5);

	glColor3f(0.0, 1.0, 1.0);
	glVertex3f(0.5, -0.5, -0.5);
	glVertex3f(-0.5, -0.5, -0.5);
	glVertex3f(-0.5, 0.5, -0.5);
	glVertex3f(0.5, 0.5, -0.5);

	glColor3f(1.0, 0.0, 1.0);
	glVertex3f(-0.5, 0.5, 0.5);
	glVertex3f(-0.5, 0.5, -0.5);
	glVertex3f(-0.5, -0.5, -0.5);
	glVertex3f(-0.5, -0.5, 0.5);

	glColor3f(1.0, 1.0, 0.0);
	glVertex3f(0.5, 0.5, -0.5);
	glVertex3f(0.5, 0.5, 0.5);
	glVertex3f(0.5, -0.5, 0.5);
	glVertex3f(0.5, -0.5, -0.5);
	glEnd();
}

// Setting global variables for later calls to achieve angular rotation
GLfloat angle = 0.0f;

// Rotating with X axis
void x_rotate(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(0, 0, -5);
	glRotatef(angle, 1.0, 0, 0);
	cube_info();
	glutSwapBuffers();
	glPopMatrix();

	angle += 5.0f;
	Sleep(20);
}

// Rotating with Y axis
void y_rotate(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(0, 0, -5);
	glRotatef(angle, 0, 1.0, 0);
	cube_info();
	glutSwapBuffers();
	glPopMatrix();

	angle += 5.0f;
	Sleep(20);
}

// Rotating with Z axis
void z_rotate(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(0, 0, -5);
	glRotatef(angle, 0, 0, 1.0);
	cube_info();
	glutSwapBuffers();
	glPopMatrix();

	angle += 5.0f;
	Sleep(20);
}

// Re-drew the window
void re_drew(int w, int h)
{
	if (h == 0) h = 1;
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(45.0, (GLfloat)w / (GLfloat)h, 0.1, 100.0);
	glMatrixMode(GL_MODELVIEW);
}

void init(int width, int height)
{
	if (height == 0) height = 1;
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glClearDepth(1.0);
	glDepthFunc(GL_LESS);
	glEnable(GL_DEPTH_TEST);
	glShadeModel(GL_SMOOTH);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(45.0, (GLfloat)width / (GLfloat)height, 1, 100.0);
	glMatrixMode(GL_MODELVIEW);
}


int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowPosition(300, 150);
	glutInitWindowSize(400, 400);
	int i;

	printf("11619370216_”Œ÷“√Ù\n");
	printf("Keep rotate with X-axis(1) or Y-axis(2) or Z-axis(3)\n");
	scanf_s("%d", &i);
	switch (i)
	{
	case 1:
		glutCreateWindow("Rotating with X-axis");
		glutDisplayFunc(x_rotate);
		glutIdleFunc(x_rotate);
		break;
	case 2:
		glutCreateWindow("Rotating with Y-axis");
		glutDisplayFunc(y_rotate);
		glutIdleFunc(y_rotate);
		break;
	case 3:
		glutCreateWindow("Rotating with Z-axis");
		glutDisplayFunc(z_rotate);
		glutIdleFunc(z_rotate);
		break;
	default:
		printf("\n Error!!\n");
	}


	glutReshapeFunc(re_drew);
	init(640, 480);
	glutMainLoop();
	return 0;
}

