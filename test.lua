--[[ Lua script for testing ]]
data = {12, 3.14, false, "hello", {SubObject="test"}};
json = json_encode(data);
print("The encoded string: " .. json);
decode_result = json_decode(json);
print("------ decode ------");
print(decode_result[1]);
print(decode_result[2]);
print(decode_result[3]);
print(decode_result[4]);
print("SubObject : " .. decode_result[5].SubObject);