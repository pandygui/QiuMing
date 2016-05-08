import QtQuick 2.0

QtObject {
    id: userEntity
    property string userId
    property string username
    property string password
    property string pickname
    property string email
    property string telephone
    property int    age
    property string address
    property string experience
    property string sex
    property int    roleId
    property string role_name
    property string introduction

    function set(user) {
        for(var iter in user) {
            // console.log("iter: "+iter)
            if(iter === "id") {
                // console.log("["+iter+"]", user[iter]);
                userEntity["userId"] = user[iter];
                // console.debug('userEntity["userId"]:' +  userEntity["userId"])
            } else {
                userEntity[iter] = user[iter];
                // console.debug('userEntity['+iter+']:' +  userEntity[iter])
            }
        }
    }

    function clear() {
        userId       = "";
        username     = "";
        password     = "";
        pickname     = "";
        email        = "";
        telephone    = "";
        age          = 0;
        address      = "";
        experience   = "";
        sex          = "";
        roleId       = 0;
        role_name    = "";
        introduction = "";
    }
}

