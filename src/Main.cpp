#include<iostream>
#include<GLFW/glfw3.h>
#include<gl/glew.h>

int main(){

std::cout<<"hello world";

GLFWwindow* window;

if(!(glfwInit())){
    return -1;
}
window = glfwCreateWindow(640, 400, "OPenGL_Prac", NULL, NULL);

while (glfwWindowShouldClose(window))
{
    glfwPollEvents();
}

glfwTerminate();
    return 0;
}