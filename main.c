/**
 * Wang Wei
 * June 2016
 **/

#include "handler.h"

static char *reader(char *pFileName)
{
    char c;
    int index = 0;
    FILE *pFile = fopen(pFileName, "r");
    if (pFile == NULL) { printf("Read file failed\n"); return NULL; }
    char *pBuf = malloc(1024);

    while ((c=getc(pFile)) != EOF) {
        if (c == '\n') { continue; }
        pBuf[index] = c;
        index++;
    }

    fclose(pFile);

    return pBuf;
}

int main()
{
    lua_State *L = luaL_newstate();

    luaL_openlibs(L);

    // register C function
    lua_register(L, "json_encode", json_encode);
    lua_register(L, "json_decode", json_decode);

    char *pLua = reader("test.lua");
    if (pLua == NULL) {
        printf("Null string\n");
        lua_close(L);
        return 0;
    }

    int err = luaL_loadbuffer(L, pLua, strlen(pLua), "line") || lua_pcall(L, 0, 0, 0);
    if (err) {
        printf("error occur\n");
        lua_pop(L, 1);
    }

    lua_close(L);

    return 0;
}
