// Created by Crowbar 0.34.0.0

$ModelName "SW_Battlefront\props\e-web\e-web_turret.mdl"

$BodyGroup "e-web"
{
	studio "e-web_turret.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$MaxEyeDeflection 90

$MostlyOpaque

$CDMaterials "models\SW_Battlefront\Weapons\emplacement\"

$Attachment "hookup" "root" 0 0 0 rotate 0 0 0
$Attachment "muzzle" "muzzle" 0 0 0 rotate 90 0 0

$CBox 0 0 0 0 0 0

$BBox -14.482 -1.618 -2.941 18.259 1.618 5.263


$Sequence "idle" {
	"power_prongs_anims\idle.smd"
	activity "ACT_DIERAGDOLL" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "e-web_turret_physics.smd"
{
	$mass 70
	$inertia 3
	$damping 0
	$rotdamping 0

}
