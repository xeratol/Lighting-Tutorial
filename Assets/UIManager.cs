using UnityEngine;
using System.Collections;

public class UIManager : MonoBehaviour
{
    [SerializeField] private GameObject _sun;

    public void OnSpeedUpdate(float speed)
    {
        _sun.GetComponent<OrbitScript>().Speed = speed;
    }

    public void OnShininessUpdate(float shininess)
    {
        //_sun.GetComponent<>()
    }
}
