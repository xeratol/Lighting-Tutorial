using UnityEngine;
using System.Collections;

public class OrbitScript : MonoBehaviour
{

    [SerializeField] private Transform _light;
    [SerializeField] private Transform _target;
    [SerializeField] private float _speed;

    public float Speed
    {
        get { return _speed; }
        set { _speed = value; }
    }


    // Update is called once per frame
	void Update ()
	{
        transform.Rotate(Vector3.up, Time.deltaTime*10);

        // translate the sun
	    float dirX = Input.GetAxis("Horizontal");
	    float dirY = Input.GetAxis("Vertical");
        transform.RotateAround(_target.position, Vector3.up, _speed * Time.deltaTime * dirX);
        transform.RotateAround(_target.position, Vector3.left, _speed * Time.deltaTime * dirY);

        // set lights rotation
        _light.rotation = Quaternion.LookRotation(_target.position - transform.position);
        
	}
}
