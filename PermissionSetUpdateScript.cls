String profileName = 'Standard Platform User'; //Make sure to use the Profile Name as per your org.
Profile prof = [Select Id, Name from Profile where Name = :profileName];
String permissionSetName ='Test_PermissionSet'; //Make sure to use API Name.
PermissionSet perSet = [Select id, Name From PermissionSet where Name =: permissionSetName];

List<User> userList =[Select Id, Name from User where ProfileId =: prof.Id And IsActive = true AND
                        Id Not In (Select AssigneeId From PermissionSetAssignment where PermissionSetId =: perSet.Id)];


System.debug('UserList size :' + userList.size()); //Debugging the size of the list
System.debug('UserList =' +userList);//Debugging the userList

if(!userList.isEmpty()){

    List<PermissionSetAssignment> permSetAssList = new List<PermissionSetAssignment>();
    for(User usr : userList){
            PermissionSetAssignment perSetAss = new PermissionSetAssignment();
            perSetAss.Assigneeid = usr.Id;
            perSetAss.PermissionSetId = perSet.Id;
            permSetAssList.add(perSetAss);//Adding the PermissionSetAssignment to the list

    }

if(!permSetAssList.isEmpty()){
    insert permSetAssList;
}
}