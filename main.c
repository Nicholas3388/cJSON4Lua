/**
 * Wang Wei
 * June 2016
 **/

#include "handler.h"


int main()
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    // register C function
    lua_register(L, "json_encode", json_encode);
    lua_register(L, "json_decode", json_decode);

    luaL_dofile(L, "test.lua");

    lua_close(L);

    return 0;
}
