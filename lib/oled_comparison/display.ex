defmodule OledComparison.Display do
  use OLEDVirtual.Display, app: :oled_comparison

  alias OledComparison.{Display, Prefix}
  require Logger

  def on_display(data, %{width: width, height: height}) do
    path = Prefix.get() <> ".png"
    bitmap = for <<bit::1 <- data>>, do: bit
    palette = [{0, 16, 16}, {0, 255, 255}]

    image =
      Pngex.new(
        type: :indexed,
        depth: :depth1,
        width: width,
        height: height,
        palette: palette
      )
      |> Pngex.generate(bitmap)

    Logger.debug(fn -> "Write file #{path}" end)
    File.write(path, image)
  end

  def test_pattern(prefix) do
    test_pattern_topLeft(prefix)
    test_pattern_topRight(prefix)
    test_pattern_bottomLeft(prefix)
    test_pattern_bottomRight(prefix)
    test_pattern_center(prefix)
  end

  def test_pattern_topLeft(prefix) do
    Display.clear()
    Prefix.set(prefix <> "tl")
    ox = 0
    oy = 0

    0..127//8
    |> Enum.reduce(nil, fn x, _acc ->
      Display.line(ox, oy, x, 63)
    end)

    0..63//8
    |> Enum.reduce(nil, fn y, _acc ->
      Display.line(ox, oy, 127, y)
    end)

    Display.display()
  end

  def test_pattern_topRight(prefix) do
    Display.clear()
    Prefix.set(prefix <> "tr")
    ox = 127
    oy = 0

    127..0//-8
    |> Enum.reduce(nil, fn x, _acc ->
      Display.line(ox, oy, x, 63)
    end)

    0..63//8
    |> Enum.reduce(nil, fn y, _acc ->
      Display.line(ox, oy, 0, y)
    end)

    Display.display()
  end

  def test_pattern_bottomLeft(prefix) do
    Display.clear()
    Prefix.set(prefix <> "bl")
    ox = 0
    oy = 63

    0..127//8
    |> Enum.reduce(nil, fn x, _acc ->
      Display.line(ox, oy, x, 0)
    end)

    63..0//-8
    |> Enum.reduce(nil, fn y, _acc ->
      Display.line(ox, oy, 127, y)
    end)

    Display.display()
  end

  def test_pattern_bottomRight(prefix) do
    Display.clear()
    Prefix.set(prefix <> "br")
    ox = 127
    oy = 63

    127..0//-8
    |> Enum.reduce(nil, fn x, _acc ->
      Display.line(ox, oy, x, 0)
    end)

    63..0//-8
    |> Enum.reduce(nil, fn y, _acc ->
      Display.line(ox, oy, 0, y)
    end)

    Display.display()
  end

  def test_pattern_center(prefix) do
    Display.clear()
    Prefix.set(prefix <> "ct")
    ox = 64
    oy = 32

    0..127//8
    |> Enum.reduce(nil, fn x, _acc ->
      Display.line(ox, oy, x, 0)
      Display.line(ox, oy, x, 63)
    end)

    0..63//8
    |> Enum.reduce(nil, fn y, _acc ->
      Display.line(ox, oy, 0, y)
      Display.line(ox, oy, 127, y)
    end)

    Display.display()
  end
end
