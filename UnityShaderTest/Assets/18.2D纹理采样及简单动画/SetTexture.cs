using UnityEngine;
using System.Collections;

public class SetTexture : MonoBehaviour {

    public int width;
    public int height;
    public int fps;
    private int index;
    private int timer;
    private Material mat;

	// Use this for initialization
	void Start () {
        index = 0;
        timer = 0;
        mat = GetComponent<Renderer>().material;
        mat.SetTextureScale("_MainTex", new Vector2(1 / (float)width, 1 / (float)height));
	}
	
	// Update is called once per frame
	void Update () {
        if (timer == 0)
        {
            mat.SetTextureOffset("_MainTex", new Vector2((float)(index % width) / (float)width, (float)(index / width) / (float)height));
            //Debug.Log(new Vector2((float)(index % width) / (float)width, (float)(index / width) / (float)height));
            
        }
        timer++;
	    if(timer == fps)
        {
            timer = 0;
            if(index < width * height -1) index++;
            else index = 0;
        }
	}
}
