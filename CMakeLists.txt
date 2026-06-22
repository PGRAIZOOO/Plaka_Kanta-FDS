cmake_minimum_required(VERSION 3.15)
project(OpenGL_Prac VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)

find_package(glfw3 CONFIG REQUIRED)
find_package(glm CONFIG REQUIRED)
find_package(GLEW CONFIG REQUIRED)

add_executable(OpenGL_Prac src/HEADERS.h src/main.cpp)
target_include_directories(OpenGL_Prac PRIVATE dependencies)


target_link_libraries(OpenGL_Prac PRIVATE 
glm::glm
GLEW::GLEW
glfw
opengl32
)