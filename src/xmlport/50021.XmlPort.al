xmlport 50021 "DEL 50021"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Permission; Permission)
            {
                XmlName = 'Permission';
                fieldelement(RoleID; Permission."Role ID")
                {
                }
                fieldelement(RoleName; Permission."Role Name")
                {
                }
                fieldelement(ObjectType; Permission."Object Type")
                {
                }
                fieldelement(ObjectID; Permission."Object ID")
                {
                }
                fieldelement(ObjectName; Permission."Object Name")
                {
                }
                fieldelement(ReadPermission; Permission."Read Permission")
                {
                }
                fieldelement(InsertPermission; Permission."Insert Permission")
                {
                }
                fieldelement(ModifyPermission; Permission."Modify Permission")
                {
                }
                fieldelement(DeletePermission; Permission."Delete Permission")
                {
                }
                fieldelement(ExecutePermission; Permission."Execute Permission")
                {
                }
                fieldelement(SecurityFilter; Permission."Security Filter")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

